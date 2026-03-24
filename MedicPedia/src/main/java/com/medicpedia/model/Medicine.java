package com.medicpedia.model;

public class Medicine {
    private int id;
    private String name;
    private String imagePath;
    private String uses;
    private String sideEffects;
    private String precautions;
    private int minAge;
    private int maxAge;
    private boolean pregnancyWarning;
    private String riskLevel;

    public Medicine() {}

    public Medicine(int id, String name, String imagePath, String uses,
                    String sideEffects, String precautions, int minAge,
                    int maxAge, boolean pregnancyWarning, String riskLevel) {
        this.id = id;
        this.name = name;
        this.imagePath = imagePath;
        this.uses = uses;
        this.sideEffects = sideEffects;
        this.precautions = precautions;
        this.minAge = minAge;
        this.maxAge = maxAge;
        this.pregnancyWarning = pregnancyWarning;
        this.riskLevel = riskLevel;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public String getUses() { return uses; }
    public void setUses(String uses) { this.uses = uses; }

    public String getSideEffects() { return sideEffects; }
    public void setSideEffects(String sideEffects) { this.sideEffects = sideEffects; }

    public String getPrecautions() { return precautions; }
    public void setPrecautions(String precautions) { this.precautions = precautions; }

    public int getMinAge() { return minAge; }
    public void setMinAge(int minAge) { this.minAge = minAge; }

    public int getMaxAge() { return maxAge; }
    public void setMaxAge(int maxAge) { this.maxAge = maxAge; }

    public boolean isPregnancyWarning() { return pregnancyWarning; }
    public void setPregnancyWarning(boolean pregnancyWarning) { this.pregnancyWarning = pregnancyWarning; }

    public String getRiskLevel() { return riskLevel; }
    public void setRiskLevel(String riskLevel) { this.riskLevel = riskLevel; }
}
