import re
import locale
import datetime

import pandas

from transliterate import translit

from django.utils import timezone
from django.conf import settings
from django.db import models


locale.setlocale(locale.LC_ALL, "ru_RU.UTF-8")


class City(models.Model):
    name = models.CharField(max_length=127)
    declination = models.CharField(max_length=127)

    latitude = models.FloatField()
    longitude = models.FloatField()

    tapable = models.BooleanField(default=True)

    def __str__(self):
        return self.reversed_name

    @property
    def reversed_name(self):
        transilted = translit(self.name, 'ru', reversed=True).lower()
        return re.sub('[^a-z0-9-]', '', transilted)

    def get_city_by_name(name):
        for city in City.objects.all():
            if city.reversed_name == name:
                return city

    def shops_geojson(self):
        return {
            'type': 'FeatureCollection',
            'features': [{
                'type': 'Feature',
                'geometry': {
                    'type': 'Point',
                    'coordinates': shop.coords,
                },
                'properties': {
                    'id': shop.id,
                    'city_name': self.name,
                    'lab_name': shop.labaratory.name,
                    'shop_name': shop.name,
                    'address': f"{shop.address}",
                    'take_text': shop.parse_take_text(),
                    'color': 'red',
                }
            } for lab in LabaratoryBranch.objects.filter(city=self)
            for shop in LabaratoryBranchShop.objects.filter(labaratory=lab)]
        }


class SamplingType(models.Model):
    name = models.CharField(max_length=255)
    site_name = models.CharField(max_length=255)

    def __str__(self):
        return translit(self.name, 'ru', reversed=True)

    def from_dict(dictionary):
        sampling = SamplingType()

        for field_name, val in dictionary.items():
            setattr(sampling, field_name, val)

        return sampling

    def create_lab_branch_sampling(self, price):
        for lab in LabaratoryBranch.objects.all():
            SamplingInLabaratoryBranch.objects.create(
                labaratory=lab,
                sampling_type=self,
                price=price
            )


class GeneralLabaratory(models.Model):
    name = models.CharField(max_length=63)
    email = models.EmailField()
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return translit(self.name, 'ru', reversed=True)


class LabaratoryBranch(models.Model):
    labaratory = models.ForeignKey('GeneralLabaratory', on_delete=models.CASCADE)
    city = models.ForeignKey('City', on_delete=models.CASCADE)

    is_tapable = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.city} @{self.labaratory}"

    @property
    def name(self):
        return self.labaratory.name

    @property
    def is_active(self):
        return self.labaratory.is_active


class LabaratoryBranchShop(models.Model):
    name = models.CharField(max_length=127)
    labaratory = models.ForeignKey('LabaratoryBranch', on_delete=models.CASCADE)

    address = models.CharField(max_length=127)
    telephone = models.CharField(max_length=127)
    latitude = models.FloatField()
    longitude = models.FloatField()

    def __str__(self):
        return f"{self.labaratory} @{translit(self.name, 'ru', reversed=True)}"

    def set_coodrs(self, latitude, longitude):
        self.latitude = latitude
        self.longitude = longitude

    @property
    def coords(self):
        return self.longitude, self.latitude

    @property
    def gen_lab(self):
        return self.labaratory.labaratory

    def parse_take_text(self):
        today = timezone.now()

        if self.labaratory.id == 3:
            if self.labaratory.city.id == 1:
                if today.hour < 13 and today.weekday() <= 4:
                    delta = 1
                elif today.hour >= 13 and today.weekday() <= 3:
                    delta = 2
                elif today.weekday() > 3:
                    delta = 8 - today.weekday()
            else:
                if today.weekday() == 4:
                    delta = 4
                elif today.hour > 13 and today.weekday() == 3:
                    delta = 4
                elif today.hour < 13 and today.weekday() <= 3:
                    delta = 2
                elif today.hour >= 13 and today.weekday() <= 3:
                    delta = 3
                elif today.weekday() > 3:
                    delta = 9 - today.weekday()

            next_date = today + datetime.timedelta(days=delta)
            month_name = next_date.strftime('%B')

            if month_name in self.scl:
                month_name = self.scl[month_name]

            text = f'Вы можете сдать анализы с {next_date.day} {month_name} в течение двух недель'
        else:
            text = "Вы можете сдать анализы с завтрашнего дня в течение двух недель"

        return text;

    scl = {
        'Январь': 'января',
        'Февраль': 'февраля',
        'Март': 'марта',
        'Апрель': 'апреля',
        'Май': 'майя',
        'Июнь': 'июня',
        'Июль': 'июля',
        'Август': 'августа',
        'Сентябрь': 'сентября',
        'Октябрь': 'октября',
        'Ноябрь': 'ноября',
        'Декабрь': 'декабря',
    }


class SamplingInLabaratoryBranch(models.Model):
    labaratory = models.ForeignKey(LabaratoryBranch, on_delete=models.CASCADE)
    sampling_type = models.ForeignKey(SamplingType, on_delete=models.CASCADE)
    price = models.IntegerField(default=0)

    def __str__(self):
        return f"{self.sampling_type} @{self.labaratory}"


class Analys(models.Model):
    labaratory = models.ForeignKey('GeneralLabaratory', on_delete=models.CASCADE)
    code = models.CharField(max_length=63)

    name = models.TextField()
    section = models.CharField(max_length=255)
    lab_section = models.CharField(max_length=255)
    description = models.CharField(max_length=1023, blank=True)
    preparations = models.TextField(blank=True)
    research_type = models.TextField(blank=True)
    blank_form = models.CharField(max_length=63, blank=True)
    synonyms_rus = models.TextField()
    synonyms_eng = models.TextField()
    sampling_type =  models.ManyToManyField(SamplingType, blank=True)

    image = models.ImageField(upload_to='analysis', default='analysis/default.jpg')


    def __str__(self):
        return f"code: {self.code} @{self.name_en}"

    @property
    def name_en(self):
        transilted = translit(self.name, 'ru', reversed=True).replace(' ', '-').lower()
        return re.sub('[^a-z0-9-]', '', transilted)

    @property
    def matched(self):
        return Matched.find_matched_by_code(self.code)

    @property
    def matched_id(self):
        matched = self.matched

        if not matched is None:
            return matched.id

        return -1
    @property
    def synonym_rus_list(self):
        return self.synonyms_rus.split(',')

    @property
    def synonym_eng_list(self):
        return self.synonyms_eng.split(',')

    def get_analys_by_name_en(name):
        for analys in Analys.objects.all():
            if analys.name_en == name:
                return analys

    def price_by_city(self, city):
        return AnalysInBranch.objects.filter(analys=self, labaratory_branch_city=city)

    def get_sections_list():
        default_lab = GeneralLabaratory.objects.get(name='Инвитро')

        sections_list = set([analys.section.capitalize() for analys in Analys.objects.filter(labaratory=default_lab)])

        return list(sections_list)

    def from_dict(row):
        analys = Analys.objects.filter(code=row['code']).first()

        if analys is None:
            analys = Analys()

        labaratory = GeneralLabaratory.objects.filter(name=row['lab_name']).first()

        if labaratory is None:
            return f'Лаборатории {row["lab_name"]} нет'

        fields = ['name', 'code', 'lab_section', 'section', 'description',
                  'preparations', 'research_type', 'blank_form',
                  'synonyms_eng', 'synonyms_rus']

        for field in fields:
            if field in row and not pandas.isna(row[field]):
                setattr(analys, field, row[field])

        analys.labaratory = labaratory

        # if not pandas.isna(row['sampling_types']):
        #     for sampling in eval(row['sampling_types']):
        #         sm = SamplingType.objects.filter(name=sampling).first()
        #
        #         if sm is None:
        #             return f"Биоматериала {sampling} нет"
        #
        #         analys.sampling_type.add(sm)
        #
        #     analys.save()

        return analys


class AnalysInBranch(models.Model):
    labaratory_branch = models.ForeignKey('LabaratoryBranch', on_delete=models.CASCADE)
    analys = models.ForeignKey('Analys', on_delete=models.CASCADE)

    lab_price = models.IntegerField()
    our_price = models.IntegerField(default=0)

    period = models.TextField()

    def __str__(self):
        return f"{self.analys} @{self.labaratory_branch}"

    @property
    def name(self):
        return self.analys.name

    @property
    def price(self):
        return int((self.lab_price - self.our_price) * 0.75 + self.our_price)

    @property
    def is_buyable(self):
        return self.our_price != 0 and self.labaratory_branch.labaratory.is_active and self.labaratory_branch.is_tapable 

    @property
    def image(self):
        return self.analys.image

    @property
    def labaratory_name(self):
        return self.labaratory.name

    @property
    def city(self):
        return self.labaratory_branch.city

    @property
    def city_name(self):
        return self.city.name

    @property
    def matched(self):
        return Matched.find_matched_by_code(self.analys.code)

    @property
    def matched_analysis(self):
        matched = self.matched

        if not matched is None:
            return matched.analysis_by_city(self.labaratory_branch.city)

        return [self]

    @property
    def matched_labaratories(self):
        return [analys.labaratory_branch.name for analys in self.matched_analysis]

    @property
    def matched_id(self):
        matched = self.matched

        if not matched is None:
            return matched.id

        return -1

    @property
    def minimal_price(self):
        matched = self.matched_analysis

        if not matched is None:
            return min([analys.price for analys in matched])

        return self.price

    def matched_labaratories_by_id(self, id):
        if id == -1:
            return self.labaratory_branch.name

        matched = Matched.objects.get(id=id)
        matched_analysis = matched.analysis_by_city(self.labaratory_branch.city)

        return [analys.labaratory_branch.name for analys in matched_analysis]

    def get_samplings(self):
        samplings_objects = SamplingInLabaratoryBranch.objects.filter(
            sampling_type__in=self.analys.sampling_type.all(),
            labaratory=self.labaratory_branch
        )

        samplings = []

        for sampling in samplings_objects:
            samplings.append({
                'id': sampling.id,
                'sampling': sampling.sampling_type,
                'price': sampling.price,
            })

        return samplings

    def from_dict(row):
        analys_branch = AnalysInBranch.objects.filter(
            analys__code=row['code'],
            labaratory_branch__labaratory__name=row['lab_name'],
            labaratory_branch__city__name=row['city_name']).first()

        if analys_branch is None:
            analys_branch = AnalysInBranch()

        analys = Analys.from_dict(row)

        if isinstance(analys, str):
            return analys

        analys.save()

        city = City.objects.filter(name=row['city_name']).first()

        if city is None:
            return f'Города {row["city_name"]} нет в базе'

        labaratory = LabaratoryBranch.objects.filter(
                                labaratory=analys.labaratory, city=city).first()
        if labaratory is None:
            return f'в городе {city.name} нет лаборатории {row["lab_name"]}'

        analys_branch.labaratory_branch = labaratory
        analys_branch.analys = analys

        fields = ['lab_price', 'our_price']

        for field in fields:
            if field in row and not pandas.isna(row[field]):
                setattr(analys_branch, field, row[field])

        analys_branch.save()

        return analys_branch


class Matched(models.Model):
    codes = models.TextField()

    def __str__(self):
        return self.codes

    def find_matched_by_code(code):
        for matched in Matched.objects.all():
            if code in matched.codes.split(';'):
                return matched

    @property
    def default_analys_name(self):
        name = ""

        for code in self.codes.split(';'):
            analys = Analys.objects.filter(code=code).first()

            if not analys is None:
                name = analys.name

                if analys.labaratory.name == settings.DEFAULT_LABORATORY_FOR_ANALYS_NAME:
                    return name

        return name

    def analysis(self):
        analysis = []

        for code in self.codes.split(';'):
            analys = Analys.objects.filter(code=code).first()
            analysis.append(analys)

        return analysis

    def analysis_by_city(self, city):
        analysis = self.analysis()
        branch_analysis = AnalysInBranch.objects.filter(analys__in=analysis, labaratory_branch__city=city)

        return branch_analysis

    def from_dict(dictionary):
        matched = Matched()

        for field_name, val in dictionary.items():
            setattr(matched, field_name, val)

        return matched
