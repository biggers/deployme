from setuptools import setup, find_packages

setup (
    name             = "DeployMe",
    version          = "0.1",
    description      = "Example application to be deployed.",
    packages         = find_packages(),
    install_requires = ["Twisted<17.0.0",
                        "klein<17.0.0",
                        "treq<17.0.0",
                        "service_identity>=14.0.0",
                        "deployme",
    ],
    entry_points     = {'console_scripts':
                        ['run-the-app = deployme:main']}
)
