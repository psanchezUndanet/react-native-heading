module.exports = {
  dependency: {
    platforms: {
      android: {
        sourceDir: './android',
        packageImportPath:
          'import com.joshblour.reactnativeheading.ReactNativeHeadingPackage;',
        packageInstance: 'new ReactNativeHeadingPackage()',
      },
      ios: {
        // opcional; normalmente no hace falta
      },
    },
  },
};