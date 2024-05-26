<div align="center">
  <img src="./app/assets/images/Cart-Shop-Icon.jpg" alt="" />
  <br/>
  <h3><b>Car Shop</b></h3>
</div>


# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [🚀 Live Demo](#live-demo)
- [💻 Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
  - [Deployment](#deployment)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [❓ FAQ (OPTIONAL)](#faq)
- [📝 License](#license)



# 📖 Cart Shop <a name="about-project"></a>

**Cart Shop** is a API (application Programming interface) that allows the user to create an shop depends of the products
and the cart items are stablish.

<img src="./app/assets/images/Database ER diagram (Cart Shoop).png"  alt= "Design Database Structure"/>

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby on Rails</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
     <li><a href="https://www.sqlite.org/index.html">SQlite</a></li>
  </ul>
</details>


### Key Features <a name="key-features"></a>

- **When an Item is added to the Car, The system must update the item, but if reduce the item to 0, must delete the item in the car shop**
- **The user can create the user name and can asses using registration and session access cookie**
- **the stock must have control of each one units, make no access adding new items when the cart doesn't have stock**
- **we have two types of items: events and products, the two types must be specific but the attributes must have price, name, thumbnail and description**
- **make documetation using rswag and Implement Testing**
- **docker the project**

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 🚀 Live Demo <a name="live-demo"></a>


- [Live Demo Link](https://google.com)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 💻 Getting Started <a name="getting-started"></a>


To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:


```sh
  ruby version 3.3.1
  gem install rails
  docker run hello-world
```


### Setup

Clone this repository to your desired folder:


```sh
  cd my-folder
  git clone git@github.com:cvalencia1991/carro-de-compras.git

```


### Install

Install this project with:

```sh
  cd my-project
  gem install
  bundle install
```

### Usage

To run the project, execute the following command:

if you are working without doker you can put this commands on the bash terminal

```sh
  bundle install
  rails server
```

if you are working on docker you need first put the image and the render the command in the terminal

```sh
  docker build -t cart-api-1 /path/to/the/project
  docker run --name api-2 -p 3000:3000 -e RAILS_MASTER_KEY=$(cat config/master.key) -e DEVISE_JWT_SECRET_KEY=your_jwt_secret_key cart-api-1
```

### Run tests

To run tests, run the following command:


```sh
  rspec .
```


### Deployment

You can deploy this project using:


```sh
  railway
  render
```


<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 👥 Authors <a name="authors"></a>

👤 **Cesar Alberto Valencia Aguilar**

- GitHub: [@githubhandle](https://github.com/cvalencia1991)
- Twitter: [@twitterhandle](https://twitter.com/twitterhandle)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/cesar-valencia-aguilar/)


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 🔭 Future Features <a name="future-features"></a>

- [ ] **Deploy in a front end framework**


<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/cvalencia1991/carro-de-compras/issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## ⭐️ Show your support <a name="support"></a>

If you like this project please give me start ⭐️

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## ❓ FAQ (OPTIONAL) <a name="faq"></a>

- **Which framework or library could use to deploy the api in the front end development**

  - you can deploy in any framework that you wan't


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

_NOTE: we recommend using the [MIT license](https://choosealicense.com/licenses/mit/) - you can set it up quickly by [using templates available on GitHub](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/adding-a-license-to-a-repository). You can also use [any other license](https://choosealicense.com/licenses/) if you wish._

<p align="right">(<a href="#readme-top">back to top</a>)</p>