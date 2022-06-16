
VERSION = $(shell cat ./VERSION)
BUILD_NUMBER = $(shell cat ./BUILDNUMBER)
BUILD_NUMBER_FILE=BUILDNUMBER
BUILD_NUMBER_LIVE = $(shell cat ./BUILDNUMBER_LIVE)
BUILD_NUMBER_LIVE_FILE=BUILDNUMBER_LIVE

incrementbuild: 
	@if ! test -f $(BUILD_NUMBER_FILE); then echo 0 > $(BUILD_NUMBER_FILE); fi
	@@echo $$(($(BUILD_NUMBER)+1)) > $(BUILD_NUMBER_FILE)

incrementbuild-live: 
	@if ! test -f $(BUILD_NUMBER_LIVE_FILE); then echo 0 > $(BUILD_NUMBER_LIVE_FILE); fi
	@@echo $$(($(BUILD_NUMBER_LIVE)+1)) > $(BUILD_NUMBER_LIVE_FILE)

release-ios:
	make incrementbuild
	flutter clean
	flutter build ios --release  --build-name=$(VERSION) --build-number=$(BUILD_NUMBER)
	cd ios/ && bundle install && bundle exec fastlane beta --verbose

release-dev:
	# make env-v3capp
	cp .env.dev .env
	make incrementbuild
	flutter clean
	flutter build apk --release --build-name=$(VERSION) --build-number=$(BUILD_NUMBER) --flavor development --target lib/main_development.dart
	firebase appdistribution:distribute build/app/outputs/flutter-apk/app-dev-release.apk  \
		--app 1:149484702300:android:e08b325f4ad2d380fcf499  \
		--groups "dev" \
		--release-notes-file "changelog.txt" 

release-dev-aab:
	# make env-v3capp
	cp .env.dev .env
	make incrementbuild
	flutter clean
	flutter build appbundle --release --build-name=$(VERSION) --build-number=$(BUILD_NUMBER) --flavor development --target lib/main_development.dart
	firebase appdistribution:distribute build/app/outputs/bundle/release/app-release.aab  \
		--app 1:149484702300:android:e08b325f4ad2d380fcf499  \
		--groups "dev" \
		--release-notes-file "changelog.txt" 

release-staging:
	# make env-v3capp
	cp .env.staging .env
	make incrementbuild
	flutter clean
	flutter build apk --release --build-name=$(VERSION) --build-number=$(BUILD_NUMBER) --flavor staging --target lib/main_staging.dart
	firebase appdistribution:distribute build/app/outputs/flutter-apk/app-staging-release.apk  \
		--app 1:149484702300:android:a90343673d34644afcf499  \
		--groups "dev" \
		--release-notes-file "changelog.txt" 

release-staging-aab:
	# make env-v3capp
	cp .env.staging .env
	make incrementbuild
	flutter clean
	flutter build appbundle --release --build-name=$(VERSION) --build-number=$(BUILD_NUMBER) --flavor staging --target lib/main_staging.dart
	firebase appdistribution:distribute build/app/outputs/bundle/release/app-release.aab  \
		--app 1:149484702300:android:a90343673d34644afcf499  \
		--groups "dev" \
		--release-notes-file "changelog.txt" 

release-live:
	# make env-v3capp
	cp .env.live .env
	make incrementbuild-live
	flutter clean
	flutter build apk --release --build-name=$(VERSION) --build-number=$(BUILD_NUMBER_LIVE) --flavor production --target lib/main_production.dart
	firebase appdistribution:distribute build/app/outputs/flutter-apk/app-live-release.apk  \
		--app 1:149484702300:android:d9d03fd0e70f6b6bfcf499  \
		--groups "uat" \
		--release-notes-file "changelog.txt" 

release-live-aab:
	# make env-v3capp
	cp .env.live .env
	make incrementbuild-live
	flutter clean
	flutter build appbundle --release --build-name=$(VERSION) --build-number=$(BUILD_NUMBER_LIVE) --flavor production --target lib/main_production.dart
	firebase appdistribution:distribute build/app/outputs/bundle/release/app-live-release.aab  \
		--app 1:149484702300:android:d9d03fd0e70f6b6bfcf499  \
		--groups "uat" \
		--release-notes-file "changelog.txt" 

test-staging:
	# make incrementbuild
	cp .env.staging .env
	flutter clean
	flutter build apk --release --build-name=$(VERSION) --build-number=$(BUILD_NUMBER) --flavor staging --target lib/main_staging.dart  --obfuscate --split-debug-info=./mobile_android_staging

test-live:
	# make incrementbuild-live
	# cp .env.live .env
	flutter clean
	flutter build appbundle --release --build-name=$(VERSION) --build-number=$(BUILD_NUMBER_LIVE) --flavor production --target lib/main_production.dart  --obfuscate --split-debug-info=./mobile_android_live

test-live-aab:
	# make incrementbuild-live
	# cp .env.live .env
	flutter clean
	flutter build appbundle --release --build-name=$(VERSION) --build-number=$(BUILD_NUMBER_LIVE) --flavor production --target lib/main_production.dart  --obfuscate --split-debug-info=./mobile_android_live
