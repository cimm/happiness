# Happiness

Happiness is a responsive web app to ask members of a group a few happiness related questions. We use it in our company to get a feeling how our colleagues are feeling. Respondents answer with a quick smiley, ranging from sad to happy.

Questions are configurable and can range from "How are you feeling today?" to "How encouraging was your manager today?". There are fixed questions, asked each time and random ones where x questions are randomly picked from a pool. The first question is send by mail on a configurable schedule (once a week, every Monday & Friday,...) and once answered brings the respondent to a page with the extra answers.

Everyone can see the aggregated results, the individual answers are never shown to keep Happiness answers anonymous. A happiness score per question is calculated as a percentage. Scores above 60 are considered good enough, but this can be configured.

You currently need a Google Apps domain, the only way to log in is via Google oAuth and everyone within that domain has full access to everything.

It's a traditional, 12-factor app ready, Ruby on Rails web app. The design is mobile first so it can easily be used on phones.

# Installation

## Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## VPS

It needs Ruby 2.3, Bundler, PostgreSQL and some connection to an SMTP server. Nothing too fancy.

```
git clone https://github.com/cimm/happiness.git
cd happiness
bundle install
```

Configure the application variables:

```
cp .env.example .env
```

Configure your database access:

```
cp config/database.yml.example config/database.yml
rake db:create db:migrate
```

And (optionally) populate the database with some sample questions:

```
rake db:seed
```
