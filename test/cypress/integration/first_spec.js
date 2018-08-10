describe('Rails using factory bot examples', function() {
  beforeEach(() => {
    cy.app('clean') // have a look at cypress/app_commands/clean.rb
  })

  it('using single factory bot', function() {
    cy.visit('/')
    cy.contains('Login').click()
    cy.contains('Guest').click()
    cy.contains('Logged in as Guest')
  })

})
