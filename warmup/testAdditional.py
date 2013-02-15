"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib


class TestAdditionalAddingUser(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)
    def testAddingExistingUser(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'ryan', 'password' : 'ryan' } )
        response = self.makeRequest("/users/add", method="POST", data = { 'user' : 'ryan', 'password' : 'ryan' } )
        self.assertResponse(response, None, -2)
    
    def testAddingLongUsername(self):
        response = self.makeRequest("/users/add", method="POST", data = { 'user' : 'a'*300, 'password' : 'password'} )
        self.assertResponse(response, None, -3)

    def testAddingLongPassword(self):
        response = self.makeRequest("/users/add", method="POST", data = { 'user' : 'ryan', 'password' : 'a'*300 } )
        self.assertResponse(response, None, -4)

    def testAddingEmptyUsername(self):
        response = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password' : 'password'} )
        self.assertResponse(response, None, -3)

class TestAdditionalLoginUser(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testLoginUser(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'bob', 'password' : 'saget'} )
        response = self.makeRequest("/users/login", method="POST", data = { 'user' : 'bob', 'password' : 'saget'} )
        self.assertResponse(response, 2, 1)

    def testMultipleLoginsUser(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'bobby', 'password' : 'saget'} )
        self.makeRequest("/users/login", method="POST", data = { 'user' : 'bobby', 'password' : 'saget'} )
        response = self.makeRequest("/users/login", method="POST", data = { 'user' : 'bobby', 'password' : 'saget'} )
        self.assertResponse(response, 3, 1)

    def testLoginWrongPassword(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'hello', 'password' : 'hello'} )
        response = self.makeRequest("/users/login", method="POST", data = { 'user' : 'hello', 'password' : 'goodbye'} )
        self.assertResponse(response, None, -1)
