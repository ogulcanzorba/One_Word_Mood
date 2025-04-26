FROM ruby:3.2

# Sistem bağımlılıklarını yükle
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# Çalışma dizinini ayarla
WORKDIR /app

# Gemfile ve Gemfile.lock dosyalarını kopyala
COPY Gemfile Gemfile.lock ./

# Gemleri yükle
RUN bundle install

# Uygulama dosyalarını kopyala
COPY . .

# Port aç
EXPOSE 3000

# Sunucuyu başlat
CMD ["rails", "server", "-b", "0.0.0.0"]
