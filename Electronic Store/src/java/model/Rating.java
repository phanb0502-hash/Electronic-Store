/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADM
 */
public class Rating {
    private int ratingID;
    private int productID;
    private int rating; // ví dụ: 1–5 sao
    private String comment;

    public Rating() {}

    public Rating(int ratingID, int productID, int rating, String comment) {
        this.ratingID = ratingID;
        this.productID = productID;
        this.rating = rating;
        this.comment = comment;
    }

    public int getRatingID() {
        return ratingID;
    }

    public void setRatingID(int ratingID) {
        this.ratingID = ratingID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
