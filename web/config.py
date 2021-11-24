import os

app_dir = os.path.abspath(os.path.dirname(__file__))

class BaseConfig:
    DEBUG = True
    POSTGRES_URL="jckuriproject3sqlserver.postgres.database.azure.com"  #TODO: Update value
    POSTGRES_USER="dbadmin@jckuriproject3sqlserver" #TODO: Update value
    POSTGRES_PW="admin_password123"   #TODO: Update value
    POSTGRES_DB="techconfdb"   #TODO: Update value
    DB_URL = 'postgresql://{user}:{pw}@{url}/{db}'.format(user=POSTGRES_USER,pw=POSTGRES_PW,url=POSTGRES_URL,db=POSTGRES_DB)
    SQLALCHEMY_DATABASE_URI = os.getenv('SQLALCHEMY_DATABASE_URI') or DB_URL
    CONFERENCE_ID = 1
    SECRET_KEY = 'LWd2tzlprdGHCIPHTd4tp5SBFgDszm'
    SERVICE_BUS_CONNECTION_STRING ='Endpoint=sb://jckuriproject3servicebus.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=YgyaGUBRFimVMOa/UvcbSmzcAzfauqjqWA7ytHSHays=' #TODO: Update value
    SERVICE_BUS_QUEUE_NAME ='notificationqueue'
    ADMIN_EMAIL_ADDRESS = 'jckuri@live.com'
    SENDGRID_API_KEY = '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' #Configuration not required, required SendGrid Account

class DevelopmentConfig(BaseConfig):
    DEBUG = True

class ProductionConfig(BaseConfig):
    DEBUG = False
