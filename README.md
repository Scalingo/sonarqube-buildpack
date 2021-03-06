# Scalingo SonarQube Buildpack

This buildpack aims at deploying a SonarQube instance on the [Scalingo](https://scalingo.com/) PaaS platform.

## Defining the Version

By default we're installing the version of SonarQube declared in the [`bin/compile`](https://github.com/Scalingo/sonarqube-buildpack/blob/master/bin/compile#L16) file. But if you want to use a specific version, you can define the environment variable `SONARQUBE_VERSION`.

```console
$ scalingo env-set SONARQUBE_VERSION=8.1.0.31237
```

## Configuration

The buildpack is expecting a PostgreSQL database to be reachable at the URL specified in the `SCALINGO_POSTGRESQL_URL`.

## One-Click Installation

To deploy SonarQube on Scalingo, click this button:

[![Deploy to Scalingo](https://cdn.scalingo.com/deploy/button.svg)](https://my.scalingo.com/deploy?source=https://github.com/Scalingo/scalingo-sonarqube)
