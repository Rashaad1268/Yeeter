# Generated by Django 4.1 on 2022-08-07 09:51

import authentication.models
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('authentication', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='username',
            field=models.CharField(error_messages={'unique': 'A user with that username already exists.'}, help_text='Required. 30 characters or fewer. Letters, digits, whitespace, and @/./+/-/_ only.', max_length=30, unique=True, validators=[authentication.models.UsernameValidator()], verbose_name='username'),
        ),
    ]
