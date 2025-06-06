define('3DSwymReportGeneratorWrapper', [], function () {
  'use strict';

  const widgetUrl = 'https://opedoussaut.github.io/AI4HT/gh-pages/3DSwymReportGenerator/';

  return {
    onLoad: function () {
      const iframe = document.createElement('iframe');
      iframe.src = widgetUrl;
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      iframe.style.border = 'none';
      document.body.appendChild(iframe);
    }
  };
});