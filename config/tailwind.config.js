const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Poppins', 'Rubik', ...defaultTheme.fontFamily.sans],
        serif: ['Lora', ...defaultTheme.fontFamily.serif]
      },
      colors: { 
        test: '#6e61fe',
        HFblue: {
          100: '#8f85fe',
          200: '#6e61fe',
          300: '#6e61fe'
        },
        HFred: {
          100: '#F7A1A1',
          200: '#f58282',
          300: '#F47B7B'
        },
        HFlight: '#f1f1f1',
        HFdark: '#737373'
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries')
  ]
};
