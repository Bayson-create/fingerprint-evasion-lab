const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    headless: true, // run headless
    defaultViewport: null,
  });
  const page = await browser.newPage();

  await page.goto('http://localhost:8080', { waitUntil: 'networkidle0' });

  // 1. extract final rendered HTML
  const html = await page.content();

  // 2. search whether the page contains typical WordPress paths
  const wpIndicators = [
    '/wp-content/',
    '/wp-includes/',
    '/wp-json',
    'generator',
    'wp-admin',
    'xmlrpc.php',
    'window.jQuery',
    'window.Vue',
  ];

  console.log('🔍 Searching for fingerprint indicators...\n');

  let found = false;
  wpIndicators.forEach(indicator => {
    if (html.includes(indicator)) {
      console.log(`❗ Found indicator: ${indicator}`);
      found = true;
    }
  });

  if (!found) {
    console.log('✅ No obvious WordPress indicators found in rendered DOM.');
  }

  // 3. list all script tags
  const scripts = await page.$$eval('script', elements =>
    elements.map(el => el.src || '[inline script]')
  );

  console.log('\n📜 Loaded Scripts:');
  scripts.forEach(src => console.log(' -', src));

  await browser.close();
})();