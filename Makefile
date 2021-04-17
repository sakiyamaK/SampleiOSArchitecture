setup:
	mint bootstrap
	mint run xcodegen xcodegen generate
	bundle install
	bundle exec pod install
	open SampleiOSArchitecture.xcworkspace
.PHONY: setup

clean:
	rm -rf *.xcodeproj
	rm -rf *.xcworkspace
	rm -rf Pods/
	rm -rf Podfile.lock
	rm -rf Gemfile.lock
.PHONY: clean

mvvm:
ifdef name
	mint run pui component MVVM ${name}
else
	@echo "make component name=<component name>"
endif
.PHONY: mvvm

viper:
ifdef name
	mint run pui component VIPER ${name}
else
	@echo "make component name=<component name>"
endif
.PHONY: viper
