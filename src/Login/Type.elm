module Login.Type exposing (..)

import HttpBuilder


-- My Modules

import User.Type as User


type Msg
    = SetUsername String
    | SetPassword String
    | ClickLoginUser
    | LoginError (HttpBuilder.Error String)
    | LoginSuccess (HttpBuilder.Response UserAux)
    | GetTokenError (HttpBuilder.Error String)
    | GetTokenSuccess (HttpBuilder.Response String)


type alias UserAux =
    { userId : Int
    , name : String
    , email : String
    , username : String
    }


type alias Model =
    { error : String
    , user : User.Model
    }
