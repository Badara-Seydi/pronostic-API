require('dotenv').config();
const API = require('../app/utils/footballAPI');

(async () => {

    await API.startScrapping();

})();