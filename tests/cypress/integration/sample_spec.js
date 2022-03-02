import DataProvider from './utils/DataProvider'

describe('My First Test', () => {
    it('Visits the Site', () => {
      cy.visit('/')

      cy.pause()

      cy.contains(DataProvider.STR_LETS_JIO).click()
      
      cy.pause()

      cy.get('legend')
        .should('be.visible')
    })
  })