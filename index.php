<?php

require_once __DIR__ . '/vendor/autoload.php';

use Alltube\ConfigFactory;
use Alltube\Controller\DownloadController;
use Alltube\Controller\FrontController;
use Alltube\Controller\JsonController;
use Alltube\LocaleManagerFactory;
use Alltube\LocaleMiddleware;
use Alltube\LoggerFactory;
use Alltube\ViewFactory;
use Slim\App;
use Slim\Container;

if (isset($_SERVER['REQUEST_URI']) && strpos($_SERVER['REQUEST_URI'], '/index.php') !== false) {
    header('Location: ' . str_ireplace('/index.php', '/', $_SERVER['REQUEST_URI']));
    die;
}

try {
    // Create app.
    $app = new App();

    /** @var Container $container */
    $container = $app->getContainer();

    // Config.
    $container['config'] = ConfigFactory::create($container);

    // Locales.
    $container['locale'] = LocaleManagerFactory::create();

    $app->add(new LocaleMiddleware($container));

$container['config'] = $config;

    // Smarty.
    $container['view'] = ViewFactory::create($container);

    // Logger.
    $container['logger'] = LoggerFactory::create($container);

    // Controllers.
    $frontController = new FrontController($container);
    $jsonController = new JsonController($container);
    $downloadController = new DownloadController($container);

    // Error handling.
    $container['errorHandler'] = [$frontController, 'error'];
    $container['phpErrorHandler'] = [$frontController, 'error'];
    $container['notFoundHandler'] = [$frontController, 'notFound'];
    $container['notAllowedHandler'] = [$frontController, 'notAllowed'];

    // Routes.
    $app->get(
    $config->basePath . '/',
        [$frontController, 'index']
    )->setName('index');

    $app->get(
    $config->basePath . '/extractors',
        [$frontController, 'extractors']
    )->setName('extractors');

    $app->any(
    $config->basePath . '/info',
        [$frontController, 'info']
    )->setName('info');

    $app->any(
    $config->basePath . '/watch',
        [$frontController, 'info']
    );

    $app->any(
    $config->basePath . '/download',
        [$downloadController, 'download']
    )->setName('download');

    $app->get(
    $config->basePath . '/locale/{locale}',
        [$frontController, 'locale']
    )->setName('locale');

    $app->get(
    $config->basePath . '/json',
        [$jsonController, 'json']
    )->setName('json');

    $app->run();
} catch (Throwable $e) {
    // Last resort if the error has not been caught by the error handler for some reason.
    die('Error when starting the app: ' . htmlentities($e->getMessage()));
}
