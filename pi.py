from os import getenv

SUPERUSER_REALM = getenv('SUPERUSER_REALM', ['super', 'administrators'])
# Your database
SQLALCHEMY_DATABASE_URI = 'mssql+pymssql://%s:%s@%s/%s' % (getenv('DB_USER'), getenv('DB_PASSWORD'), getenv('DB_HOSTNAME'), getenv('DB_DATABASE'))
# This is used to encrypt the auth_token
SECRET_KEY = getenv('SECRET_KEY')
# This is used to encrypt the admin passwords
PI_PEPPER = getenv('PI_PEPPER')
# This is used to encrypt the token data and token passwords
PI_ENCFILE = '/home/pi/etc/privacyidea/enckey'
# This is used to sign the audit log
PI_AUDIT_KEY_PRIVATE = '/home/pi/etc/privacyidea/private.pem'
PI_AUDIT_KEY_PUBLIC = '/home/pi/etc/privacyidea/public.pem'
# PI_AUDIT_MODULE = <python audit module>
# PI_AUDIT_SQL_URI = <special audit log DB uri>
# PI_LOGFILE = '....'
PI_UI_DEACTIVATED = getenv('PI_UI_DEACTIVATED') == 'True'
# PI_LOGLEVEL = 20
# PI_INIT_CHECK_HOOK = 'your.module.function'
# PI_CSS = '/location/of/theme.css'