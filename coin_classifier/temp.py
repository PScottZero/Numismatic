from os import listdir, mkdir, path
from PIL import Image

d = listdir('images1/')
if '.DS_Store' in d:
    d.remove('.DS_Store')

mkdir('images2/')


def number_to_grade(number):
    if number >= 60:
        return 'MS'
    elif number >= 50:
        return 'AU'
    elif number >= 40:
        return 'XF'
    elif number >= 20:
        return 'VF'
    elif number >= 12:
        return 'F'
    elif number >= 8:
        return 'VG'
    elif number >= 4:
        return 'G'
    elif number == 3:
        return 'AG'
    elif number == 2:
        return 'FR'
    elif number == 1:
        return 'PO'
    return ''


for grade in d:
    for img_name in listdir('images1/%s/' % grade):
        img = Image.open('images1/%s/%s' % (grade, img_name))
        grade_text = number_to_grade(int(img_name.split('-')[-1].replace('o',
                                                                         '').replace('r', '').replace('.jpg', '')))
        if not path.isdir('images2/%s' % grade_text):
            mkdir('images2/%s' % grade_text)
        img.save('images2/%s/%s' % (grade_text, img_name))
