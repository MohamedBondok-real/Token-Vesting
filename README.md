# Token Vesting Smart Contract

A Solidity smart contract designed to manage ERC-20 token vesting schedules for a designated beneficiary.

## Overview

Token Vesting is a smart contract project focused on controlling when allocated tokens become available for release. It introduces configurable vesting parameters, including a cliff period, a vesting duration, and a token allocation amount.

The project demonstrates core Solidity concepts such as contract interfaces, timestamps, state variables, access to ERC-20 token functionality, and time-based release conditions.

## Features

* **ERC-20 Integration:** Interacts with an external token contract through an interface.
* **Configurable Beneficiary:** Defines the address designated to receive the vested tokens.
* **Cliff Period:** Sets an initial waiting period before tokens can be released.
* **Vesting Duration:** Configures the total vesting period.
* **Release Tracking:** Tracks the total amount of tokens released.
* **Releasable Amount Calculation:** Provides a function to query the amount currently available for release.

## Tech Stack

* Solidity `^0.8.31`
* ERC-20 token interface
* Ethereum smart contract development

## Contract Parameters

| Parameter                       | Description                                          |
| ------------------------------- | ---------------------------------------------------- |
| `_token`                        | Address of the ERC-20 token contract                 |
| `_beneficiary`                  | Address designated to receive tokens                 |
| `_start`                        | Vesting start timestamp                              |
| `_cliffDurationInMonths`        | Cliff duration in months                             |
| `_totalVestingDurationInMonths` | Total vesting duration in months                     |
| `_amount`                       | Total token allocation in the token's smallest units |

## Main Functions

### `release()`

Releases the calculated amount of available tokens to the beneficiary and updates the released-token counter.

### `releasableAmount()`

Returns the difference between the calculated vested amount and the amount already released.

### `vestedAmount()`

Calculates the amount considered vested based on the contract's current timestamp and configured vesting parameters.

## How It Works

1. Deploy the contract with the token address, beneficiary, start timestamp, cliff duration, total vesting duration, and allocation amount.
2. The contract stores the vesting configuration.
3. Once the cliff condition is satisfied, the beneficiary can trigger the release function.
4. The contract calculates the releasable amount and transfers the tokens to the beneficiary.

**Important:** The ERC-20 tokens must be available at the vesting contract address for releases to succeed.

## Current Limitations

* The current `vestedAmount()` implementation does not yet correctly implement gradual vesting. Its conditional logic returns the full allocation once the cliff is reached, rather than progressively vesting tokens over time.
* The return value of the ERC-20 `transfer()` call is not checked.
* The contract does not currently include automated tests or deployment scripts in the provided source file.

These limitations should be addressed before using the contract with real assets.

## Future Improvements

* Implement correct linear or interval-based vesting calculations.
* Validate token transfers and handle failures safely.
* Add comprehensive unit and edge-case tests.
* Add deployment scripts and usage examples.
* Consider access control, emergency handling, and additional input validation.

## Disclaimer

This project is intended for educational purposes and Solidity development practice. It has not been audited and should not be used to manage real funds without further development, testing, and security review.

## License

This project is licensed under the MIT License.
