# Generated by Django 4.1.7 on 2023-12-06 19:09

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('abs_app', '0016_alter_parkingspace_time_parked_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='parkingspace',
            name='vehicle',
            field=models.ForeignKey(default=None, null=True, on_delete=django.db.models.deletion.SET_DEFAULT, related_name='parking_space', to='abs_app.vehicle'),
        ),
    ]
