//= require prime_numbers

describe('isPrime', function() {
  it('should be true for prime numbers', function() {
    isPrime(2).should.be.true;
    isPrime(3).should.be.true;
  });
  it('should be false for numbers with non-trivial divisors', function() {
    isPrime(4).should.be.false;
    isPrime(6).should.be.false;
  });
  it('should be false for 0 and 1', function() {
    isPrime(0).should.be.false;
    isPrime(1).should.be.false;
  });
});