pragma solidity ^0.8.4;

import '@openzeppelin/contracts/utils/Context.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract NOAHBAY is ERC20 {

    /* Events */
    event TransactionInitiated(address sender, address recipient, uint amount);
    event TaxationCompleted(address sender, address recipient, uint amount);
    event TransactionCompleted(address sender, address recipient, uint amount);

    address public founder = 0x2d54EC30Be0D2583b0d781e10B31905c3c54616d;

    string private _name = 'NOAHBAY';
    string private _symbol = 'NOAHBAY';

    uint private _taxMinimum = 500;
    string private _taxMinimumErrorMessage = 'ERROR: Minimum tax threshold not satisfied. Transaction denied.';

    constructor() ERC20 (_name, _symbol) {
        _mint(_msgSender(), 10 ** 12 * 10 ** 18);
    }

    function _transfer(address _sender, address _recipient, uint _amount) internal override {
        emit TransactionInitiated(_sender, _recipient, _amount);

        /* Assess Burn */
        uint burnAmount = (_amount * 150) / 10000;
        uint amountBurned = _amount - burnAmount;

        /* Assess Tax */
        uint taxAmount = (amountBurned * 17) / 10000;
        _verifyTax(_amount, taxAmount);

        uint amountTaxedAndBurned = amountBurned - taxAmount;

        /* Burn */
        super._burn(_sender, burnAmount);

        /* Distribute */
        super._transfer(_sender, founder, taxAmount);
        emit TaxationCompleted(_sender, founder, _amount);

        super._transfer(_sender, _recipient, amountTaxedAndBurned);
        emit TransactionCompleted(_sender, _recipient, _amount);
    }

    error InsufficientTax(uint amount, uint minimumTaxRequired);

    /**
    * Enforces tax minimum threshold.
    */
    function _verifyTax(uint _amount, uint _taxAmount) private {
        if (_taxAmount < _taxMinimum) {
            revert InsufficientTax({
                amount: _amount,
                minimumTaxRequired: _taxMinimum
            });
        }
    }
}
