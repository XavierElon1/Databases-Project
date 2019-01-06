module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getPeople(res, mysql, context, complete){
        mysql.pool.query("SELECT C.id, C.name AS Name, R.raceName AS Race, F.factionName AS Faction, W.weaponName AS Weapon, T.techName AS Tech, M.magicName AS Magic
FROM shadowrun_characters C
INNER JOIN shadowrun_race R ON R.id = C.race_id
INNER JOIN shadowrun_factions F ON F.id=C.faction_id
INNER JOIN shadowrun_weapons W ON W.id=C.weapon_id
INNER JOIN shadowrun_tech T ON T.id=C.tech_id
INNER JOIN shadowrun_magic M ON M.id=C.magic_id
ORDER BY Name;", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.people = results;
            complete();
        });
    }

    function getPeoplebyRace(req, res, mysql, context, complete){
      var query = "SELECT raceName, special_ability, essence, healthInput
FROM shadowrun_race
WHERE id=?;
      console.log(req.params)
      var inserts = [req.params.raceInput]
      mysql.pool.query(query, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.people = results;
            complete();
        });
    }


    function getPerson(res, mysql, context, id, complete){
        var sql = "SELECT id, name, race_id, faction_id, weapon_id, magic_id, tech_id  FROM shadowrun_characters;";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.person = results[0];
            complete();
        });
    }

    /*Display all people. Requires web based javascript to delete users with AJAX*/

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteperson.js","filterpeople.js","searchpeople.js"];
        var mysql = req.app.get('mysql');
        getPeople(res, mysql, context, complete);
        getPlanets(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('people', context);
            }

        }
    });

    /*Display all people from a given homeworld. Requires web based javascript to delete users with AJAX*/
    router.get('/filter/:homeworld', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteperson.js","filterpeople.js","searchpeople.js"];
        var mysql = req.app.get('mysql');
        getPeoplebyHomeworld(req,res, mysql, context, complete);
        getPlanets(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('people', context);
            }

        }
    });

    /*Display all people whose name starts with a given string. Requires web based javascript to delete users with AJAX */
    router.get('/search/:s', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteperson.js","filterpeople.js","searchpeople.js"];
        var mysql = req.app.get('mysql');
        getPeopleWithNameLike(req, res, mysql, context, complete);
        getPlanets(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('people', context);
            }
        }
    });

    /* Display one person for the specific purpose of updating people */

    router.get('/:id', function(req, res){
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["selectedplanet.js", "updateperson.js"];
        var mysql = req.app.get('mysql');
        getPerson(res, mysql, context, req.params.id, complete);
        getPlanets(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('update-person', context);
            }

        }
    });

    /* Adds a person, redirects to the people page after adding */

    router.post('/', function(req, res){
        console.log(req.body.)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO shadowrun_characters (name, leader, race_id, faction_id, weapon_id, magic_id, tech_id) VALUES (?,?,?,?,?,?,?)";
        var inserts = [req.body.name, req.body.leader, req.body.race_id, req.body.faction_id, req.body.weapon_id, req.body.magic_id, req.body.tech_id];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/character_form');
            }
        });
    });

    /* Adds a race, redirects to the people page after adding */

    router.post('/', function(req, res){
        console.log(req.body.homeworld)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO shadowrun_race (raceName, special_ability, essence, health) VALUES (?,?,?,?)";
        var inserts = [req.body.raceNameInputame, req.body.specialAbilityInput, req.body.essenceInput, req.body.healthInput];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/race_form');
            }
        });
    });

    /* Adds a faction, redirects to the people page after adding */
    router.post('/', function(req, res){
        console.log(req.body.homeworld)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO shadowrun_factions (factionName, leader_id) VALUES (?,?)";
        var inserts = [req.body.factionNameInput, req.body.character_id_from_dropdown_input];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/factions_form');
            }
        });
    });

    /* Adds a weapon, redirects to the people page after adding */
    router.post('/', function(req, res){
        console.log(req.body.homeworld)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO shadowrun_weapons (weaponName, damage) VALUES (?,?)";
        var inserts = [req.body.weaponName, req.body.damageInput];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/weapons_form');
            }
        });
    });

    /* Adds a tech, redirects to the people page after adding */
    router.post('/', function(req, res){
        console.log(req.body.homeworld)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO shadowrun_tech (techName, essence_possession) VALUES (?,?)";
        var inserts = [req.body.techNameInput, req.body.essencePossessionInput];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/tech_form');
            }
        });
    });

    /* Adds a magic, redirects to the people page after adding */
    router.post('/', function(req, res){
        console.log(req.body.homeworld)
        console.log(req.body)
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO shadowrun_magic (magicName, essence_usage) VALUES (?,?)";
        var inserts = [req.body.magicNameInput, req.body.essenceUsageInput];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(JSON.stringify(error))
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/magic_form');
            }
        });
    });


    /* The URI that update data is sent to in order to update a person */

    router.put('/:id', function(req, res){
        var mysql = req.app.get('mysql');
        console.log(req.body)
        console.log(req.params.id)
        var sql = "UPDATE shadowrun_characters SET name=?, leader=?, race_id=?, faction_id=?, weapon_id=?, magic_id=?, tech_id=? WHERE id=?";
        var inserts = [req.body.nameInput, req.body.leaderInput, req.body.raceInput, req.body.factionInput, req.body.weaponInput, req.body.magicInput, req.body.techInput];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                console.log(error)
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.status(200);
                res.end();
            }
        });
    });

    /* Route to delete a person, simply returns a 202 upon success. Ajax will handle this. */

    router.delete('/:id', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM shadowrun_characters WHERE character_id = ?";
        var inserts = [req.params.id];
        sql = mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.status(400);
                res.end();
            }else{
                res.status(202).end();
            }
        })
    })

    return router;
}();
