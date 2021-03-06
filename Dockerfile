FROM python:2

RUN apt-get update && apt-get install -y --no-install-recommends curl

WORKDIR /app

COPY requirements.txt /app/requirements.txt

RUN pip install -r requirements.txt

COPY . .

RUN python manage.py syncdb --noinput

RUN python manage.py migrate

EXPOSE 80

CMD ["python", "./manage.py", "runserver", "0.0.0.0:80"]
