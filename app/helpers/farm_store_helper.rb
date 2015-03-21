module FarmStoreHelper
  # Standard Tax Rate must be defined, for farm_store to work. It can be defined in any way.
  # This needs to be a variable, because global tax rate changes are so common. A typical
  # implementation would map STANDARD_TAX_RATE to a variable on a Store level db record.
  ::STANDARD_TAX_RATE = 9.2


end