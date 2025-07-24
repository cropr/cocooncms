ARG PYTHON_VERSION=3.12-slim

FROM python:${PYTHON_VERSION}

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


# Install uv.
COPY --from=ghcr.io/astral-sh/uv:0.5.0 /uv /uvx /bin/

COPY . /app
WORKDIR /app

RUN uv sync --frozen --no-cache

EXPOSE 8000

CMD ["uv", "run", "gunicorn","--bind",":8000","--workers","2","cocooncms.wsgi"]
