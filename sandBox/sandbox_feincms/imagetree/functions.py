from PIL import Image as pil_image
from django.core import files

def cropImage(image, width, height):           
    image = pil_image.open(image.path)   
    image.thumbnail((width, height), pil_image.ANTIALIAS)
    image_temp = files.temp.NamedTemporaryFile()
    image.save(image_temp,'jpeg')
    image_temp.flush()  
    return image_temp