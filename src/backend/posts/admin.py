from django.contrib import admin

from . import models


@admin.register(models.Post)
class PostsAdmin(admin.ModelAdmin):
    list_display = ('id', 'author', 'created_at')


@admin.register(models.Reply)
class ReplyAdmin(admin.ModelAdmin):
    list_display = ('id', 'author', 'created_at')
