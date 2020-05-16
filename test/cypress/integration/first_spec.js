describe('Login as guest', function() {
  beforeEach(() => {
    cy.app('clean') // have a look at cypress/app_commands/clean.rb
  })

  it('logins successfully', function() {
    cy.visit('/')
    cy.contains('Login').click()
    cy.contains('Guest').click()
    cy.contains('Logged in as Guest')
    cy.get('.close > span').click()
    cy.get('body').should('not.contain', 'Logged in as Guest')
  })

})
