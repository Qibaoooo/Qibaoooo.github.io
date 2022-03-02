import DataProvider from './utils/DataProvider'

describe('My First Test', () => {
    it('Visits the Site', () => {
      cy.visit('/')

      cy.contains(DataProvider.STR_LETS_JIO).click()

      cy.get('legend')
        .should('be.visible')
    })
  })