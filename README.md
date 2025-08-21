# PHPMailer Dev

## Description

This is a development environment for PHPMailer.

## Requirements

- Lando
- Composer

## Installation

1. Clone the PHPMailer repository into the `phpmailer` directory as `PHPMailer` foider
2. Go into the PHPMailer directory and run `composer install`
3. Run `lando start` to start the development environment

## Testing

1. Run `lando test` to run the tests
2. Run `lando test-all` to run all the tests including the excluded groups
3. Run `lando test-qmail` to run the tests with
4. Run `test-nombstring` to run the tests without the mbstring extension

## TODOs

1. Add full Qmail testing support with the rest of the tests.
2. Add full support for testing without the mbstring extension just using the PHPMailer mbstringwrapper.

## Changelog

1.2.0 - 2025-08-22 - Added support for testing without the imap extension
1.1.1 - 2025-08-12 - Added Qmail support for Xdebug
1.1.0 - 2025-08-12 - Added Qmail support
1.0.0 - 2025-08-12 - Initial release