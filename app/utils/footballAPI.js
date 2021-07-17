const axios = require('axios');
const log = require('log-beautify');
const client = require('../client');

const API = {
    // API URL
    URL: 'https://apiv3.apifootball.com/',
    KEY: `APIkey=e3667f51c4559e8688055fd6a57eb58a9418ba7056a884b5af3e79b71104d117`,
    ACTIONS: {
        getCountries: '?action=get_countries',
        getLeagues: '?action=get_leagues',
        getTeams: '?action=get_teams',
    },
    COUNTRIES: ['France','Brazil','Russia','England', 'Germany', 'Italy', 'Spain', 'WorldCup', 'Portugal', 'eurocups'],

    async startScrapping() {
        const startTime = new Date();
        log.info(`Start scrapping`);
        await this.scrapCountries();
        log.success(`Scrap finished successfully in ${Date.now() - startTime} ms`);
    },

    async scrapCountries() {
        const countries = await this.getAllCountries();
        for(const country of countries) {
            try {
                log.info(`(${country.country_id}) ${country.country_name} found!`);
                await this.insertCountry(country);
            } catch (error) {
                return log.error(error);
            }
        }
    },

    // Get countries
    async getAllCountries() {
        const results = await axios.get(`${this.URL}/${this.ACTIONS.getCountries}&${this.KEY}`);
        return results.data;
    },

    async insertCountry(country) {
        try {
            await client.query(`INSERT INTO football_country (api_id, name, logo) VALUES ($1, $2, $3);`, [country.country_id, country.country_name, country.country_logo]);
            log.success(`${country.country_name} inserted!`);
            
            log.warn(`(${country.country_id}) Get all leagues from ${country.country_name}`);
            const leagues = await this.getLeagues(country.country_id);

            for(const league of leagues) {
                log.info(`--- (${country.country_id}) new league for ${country.country_name} found! (${league.league_name})`);
                this.insertLeague(league);
            }

        } catch (error) {
            return log.error(error);
        }
    },
    
    // Get all leagues from country
    async getLeagues(countryID) {
        const results = await axios.get(`${this.URL}/${this.ACTIONS.getLeagues}&country_id=${countryID}&${this.KEY}`);
        return results.data
    },

    async insertLeague(league) {
        try {

            // Sometimes, the league haven't got a logo, so we need to check it, and put the logo of his country
            let logoURL = league.league_logo;

            if(!logoURL) {
                logoURL = league.country_logo;
            }

            await client.query(`INSERT INTO football_league (api_id, label, logo_image_url, country_id) VALUES ($1, $2, $3, $4);`, [league.league_id, league.league_name, logoURL, league.country_id]);
            log.success(`--- ${league.league_name} inserted!`);
            
            log.warn(`--- (${league.league_id}) Get all teams from ${league.league_name}`);
            const teams = await this.getTeams(league.league_id);

            for(const team of teams) {
                log.info(`------ (${league.league_id}) new team for ${league.league_name} found! (${team.team_name})`);
                this.insertTeam(team, logoURL, league.league_id);
            }

        } catch (error) {
            return log.error(error);
        }
    },

    // Get all teams from leagues
    async getTeams(leagueID) {
        const results = await axios.get(`${this.URL}/${this.ACTIONS.getTeams}&league_id=${leagueID}&${this.KEY}`);
        return results.data
    },

    async insertTeam(team, leagueLogoURL, leagueID) {
        try {
            // Sometimes, the team haven't got a logo, so we need to check it, and put the logo of his league / country
            let logoURL = team.team_badge;

            if(!logoURL) {
                logoURL = leagueLogoURL;
            }

            await client.query(`INSERT INTO football_team (api_id, label, logo_image_url, league_id) VALUES ($1, $2, $3, $4);`, [team.team_key, team.team_name, logoURL, leagueID]);
            log.success(`--- ${team.team_name} inserted!`);

        } catch (error) {
            return log.error(error);
        }
    }
}

module.exports = API;