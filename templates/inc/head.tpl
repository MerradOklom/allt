{locale path="Translations" domain="Alltube"}
<!Doctype HTML>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name=viewport content="width=device-width, initial-scale=1">
{if isset($description)}
    <meta name="description" content="{$description|escape}" />
    <meta name="twitter:description" content="{$description|escape}" />
    <meta property="og:description" content="{$description|escape}" />
{/if}
<link rel="stylesheet" href="{base_url}/dist/main.css" />
<title>AllTube Download{if isset($title)} - {$title|escape}{/if}</title>
<link rel="canonical" href="{$canonical}" />
<link rel="icon" href="{base_url}/img/favicon.png" />
<meta property="og:title" content="AllTube Download{if isset($title)} - {$title|escape}{/if}" />
<meta property="og:image" content="{base_url}/img/logo.png" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:title" content="AllTube Download{if isset($title)} - {$title|escape}{/if}" />
<meta name="twitter:image" content="{base_url}/img/logo.png" />
<meta name="twitter:creator" content="@Tael67" />
<script type="text/javascript" src="https://www.gstatic.com/cv/js/sender/v1/cast_sender.js"></script>
<meta name="theme-color" content="#4F4F4F">
<link rel="manifest" href="manifest.json" />
</head>
<body class="{$class}">
