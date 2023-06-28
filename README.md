# A Spotify API Starter

## Dependencias
Solamente ruby 2.7.2, parte de mi objetivo es que fuese "gem free".

## Ejecución
Colocar un archivo credentials.json en el directorio raíz, con el siguiente formato:
```
{
  "client_id": "tu_client_id_api_key",
  "client_secret": "tu_client_secret_api_key"
}
```
en caso de no hacerlo, el programa te va apreguntasr las credenciales por la línea de comandos (se puede copiar y pegar y no muestra en la pantalla el input, ya que debería ser secreto), así funciona en replit =).