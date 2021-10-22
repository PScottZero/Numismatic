from os import listdir, mkdir, path
from PIL import Image

d = listdir('images/')
if '.DS_Store' in d:
    d.remove('.DS_Store')

mkdir('obv_imgs/')
mkdir('rev_imgs/')

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


for coin_type in d:
    for img_name in listdir('images/%s/' % coin_type):
        img = Image.open('images/%s/%s' % (coin_type, img_name))
        if img_name.replace('.jpg', '')[-1] == 'o':
            if not path.isdir('obv_imgs/%s' % coin_type):
                mkdir('obv_imgs/%s' % coin_type)
            img.save('obv_imgs/%s/%s' % (coin_type, img_name))
        else:
            if not path.isdir('rev_imgs/%s' % coin_type):
                mkdir('rev_imgs/%s' % coin_type)
            img.save('rev_imgs/%s/%s' % (coin_type, img_name))
