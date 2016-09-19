module Cadastro.Type exposing (..)

import Http


type alias Model =
    { username : String
    , name : String
    , password : String
    , email : String
    , error : String
    , token : String
    , name_server : String
    }


type Msg
    = SetUsername String
    | SetEmail String
    | SetName String
    | SetPassword String
    | ClickRegisterUser
    | GetUserSuccess String
    | UserError Http.Error
    | ClickLoginUser
    | LoginSuccess String
