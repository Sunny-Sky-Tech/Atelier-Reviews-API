# Atelier-Reviews-API

Custom API to serve the product reviews section to an existing e-commerce client.

## Technologies

- Server: Node, Express
- DBMS: PostgreSQL
- Deployment: AWS, Docker 
- Dev Testing: k6
- Production Testing: Loader.io

## Installation

Install [PostgreSQL](https://www.postgresql.org/docs/9.3/tutorial-createdb.html)

```
$ git clone https://github.com/ycfan23/Atelier-Products-API.git
```

Install dependencies with `npm`

```
$ npm install
$ npm start
```

## API Reference

### List Reviews

> Retrieves the list of reviews.

`GET /reviews`

Query Parameters

| Parameter  | Type    | Description                                                                         |
| :--------- | :------ | :---------------------------------------------------------------------------------- |
| product_id | integer | Selects the product for which to return reviews of.                                 |
| page       | integer | Selects the page of results to return. Default 1.                                   |
| count      | integer | Specifies how many results per page to return. Default 10.                          |

Response:
`Status: 200 OK`

---

### Get Review Meta Info

> Returns review meta data for specific product

`GET /reviews/meta`

Query Parameters

| Parameter  | Type    | Description                                                    |
| :--------- | :------ | :------------------------------------------------------------- |
| product_id | integer | `REQUIRED` ID of the product request                           |

Response:
`Status: 200 OK`

---

### Get Product Styles

> Posts a review for a product.

`POST /reviews`

Response:
`Status: 201`

---

### Report Review

> Marks review as having been reported.

`PUT /:review_id/report`

Query Parameters

| Parameter  | Type    | Description                                                    |
| :--------- | :------ | :------------------------------------------------------------- |
| review_id | integer | `REQUIRED` ID of the review being reported                      |

Response:
`Status: 204`

---

### Helpful Review

> Marks review as having been helpful.

`PUT /:review_id/helpful`

Query Parameters

| Parameter  | Type    | Description                                                    |
| :--------- | :------ | :------------------------------------------------------------- |
| review_id | integer | `REQUIRED` ID of the helpful review.                            |

Response:
`Status: 204`

---

## Author

[Zacharia Lentz](https://www.linkedin.com/in/zacharia-lentz/)
