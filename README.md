# Ipsma
---
Ipsma is an mobile iOS app that allows user to create an event and invite people within the user's contact list. User can pick location where they want to create the event, set the event detail and pass their invitation via SMS text / email.

Devpost: https://devpost.com/software/ipsma-invites

## Table of Contents
  * [App Design](#app-design)
    * [Objective](#objective)
    * [Audience](#audience)
    * [Experience](#experience)
  * [Technical](#technical)
    * [Screens](#Screens)
    * [External services](#external-services)
    * [Views, View Controllers, and other Classes](#Views-View-Controllers-and-other-Classes)

---

### App Design

#### Objective
Being able to create an event and invite other people through text.

#### Audience
Event creator / organizer

#### Experience
With Ipsma, you don't have to worry about the people you are inviting wether they have the Ipsma app or not. All invitations are send via text/email.

[Back to top ^](#)

---

### Technical

#### Screens
* Google Sign in
* MapView
* Event Detail View
* Invitation view

#### External services
* Firebase
* Firebase Invites & Dynamic Links
* Google Authentication
* MapKit
* CoreLocation

#### Views, View Controllers, and other Classes
* Views
  * GoogleSignIn.swift
  * InvitationViewController.swift
* View Controllers
  * ViewController.swift
  * LocationSearchTable.swift
* Other Classes
  * UserData.swift

#### Data models
* UserData.swift

[Back to top ^](#)

---
![simulator screen shot dec 22 2016 16 15 39](https://cloud.githubusercontent.com/assets/17153572/21464886/4ddd8f1c-c940-11e6-9a1f-01a6e01a0a27.png)

![simulator screen shot dec 22 2016 16 16 30](https://cloud.githubusercontent.com/assets/17153572/21464889/642a1bc8-c940-11e6-871b-7908c5ba0d61.png)

![simulator screen shot dec 22 2016 16 16 52](https://cloud.githubusercontent.com/assets/17153572/21464891/7734a616-c940-11e6-81f5-8d5c35b7a832.png)

![simulator screen shot dec 22 2016 16 17 07](https://cloud.githubusercontent.com/assets/17153572/21464893/8a877eaa-c940-11e6-81f0-e69f9edc8644.png)
