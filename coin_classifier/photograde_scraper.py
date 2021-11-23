import os
import json
import requests

base_url = 'https://i.pcgs.com/s3/cu-pcgs/Photograde/250/'
image_dir = 'images/'
grades = ['70', '69', '68', '67', '66', '65', '64', '63', '62', '61', '60',
          '58', '55', '53', '50', '45', '40', '35', '30', '25', '20', '15',
          '12', '10', '8', '6', '4', '3', '2', '1']

if not os.path.isdir(image_dir):
    os.mkdir(image_dir)

types_file = open('../assets/json/coin-types.json')
types_json = json.load(types_file)
types = set()

for coin_type in types_json:
    if 'photogradeName' in coin_type:
        types.add(coin_type['photogradeName'])
    else:
        types.add(coin_type['name'].replace(' ', ''))

types = sorted(list(types))
types = ['DrapedDolSE']

for photograde_type in types:
    for grade in grades:
        grade = format(int(grade), '02d')
        for side in ['o', 'r']:
            img_name = '%s-%s%s' % (photograde_type, grade, side)
            img_class_dir = 'images/%s' % photograde_type
            img_dir = '%s/%s.jpg' % (img_class_dir, img_name)
            if not os.path.isdir(img_class_dir):
                os.mkdir(img_class_dir)
            if os.path.isfile(img_dir):
                print('EXST %s' % img_name)
            else:
                try:
                    img = requests.get('%s%s-%s%s.jpg' %
                                       (base_url, photograde_type, grade, side), timeout=2)
                    if (img.status_code == 200):
                        print('SAVE %s' % img_name)
                        with open(img_dir, 'wb') as f:
                            f.write(img._content)
                except requests.exceptions.ReadTimeout:
                    print('FAIL %s' % img_name)
