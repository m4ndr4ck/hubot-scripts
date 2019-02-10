BLACKLISTED_USERS = [
  'm4ndr4ck' # Restrict access for a user ID for a contractor
]
module.exports = (robot) ->
 robot.respond /ARTEFATO=(.*) AMBIENTE=(.*)/i, (res) ->
  data = JSON.stringify({
     user: 'rocketchatadminuser' 
     password: 'pass'
  })
  userId = ''
  authToken = ''
  robot.http("http://localhost:3000/api/v1/login")
     .header('Content-Type', 'application/json')
     .post(data) (err, jres, body) ->
      if jres.statusCode isnt 200
       jres.reply "Erro em autenticar com API Rocketchat"
       return
      jresp = JSON.parse body
      userId = jresp["data"]["userId"]
      authToken = jresp["data"]["authToken"]
      robot.http("http://localhost:3000/api/v1/users.info?userId=#{res.message.user.id}")
       .header('X-Auth-Token', "#{authToken}")
       .header('X-User-Id', "#{userId}")
       .get() (err, gres, gbody) ->
        a = res.match[0]
        b = res.match[1]
        ambiente = res.match[2]
        gresp = JSON.parse gbody
        roles = gresp["user"]["roles"]
        if 'fabrica' in roles
         if ambiente != "DEV"
          res.reply "Deploy negado. Ambiente permitido: DEV"
          return
        res.reply "ARTEFATO: #{b} | AMBIENTE: #{ambiente} | #{res.message.user.name} | #{res.message.user.id} | #{userId} | #{authToken}"
