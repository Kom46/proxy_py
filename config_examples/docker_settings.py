from ._settings import *

DEBUG = False

# override db settings here
DATABASE_CONNECTION_KWARGS["host"] = "172.168.1.2"
DATABASE_CONNECTION_KWARGS["database"] = "proxy_py"
DATABASE_CONNECTION_KWARGS["user"] = "proxy_py"
DATABASE_CONNECTION_KWARGS["password"] = "proxy_py"

PROXY_PROVIDER_SERVER_ADDRESS = {
    "HOST": "0.0.0.0",
    "PORT": 55555,
}
