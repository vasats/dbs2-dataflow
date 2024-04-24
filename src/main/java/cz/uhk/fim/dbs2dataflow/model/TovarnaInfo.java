package cz.uhk.fim.dbs2dataflow.model;

public class TovarnaInfo extends Tovarna{
    private Integer pocetHal;
    private String mesto;

    public Integer getPocetHal() {
        return pocetHal;
    }

    public void setPocetHal(Integer pocetHal) {
        this.pocetHal = pocetHal;
    }
    public TovarnaInfo(Tovarna tovarna, int pocetHal, String mesto){
        super();
        setMesto(mesto);
        setAdresa(tovarna.getAdresa());
        setCenaZaKwh(tovarna.getCenaZaKwh());
        setFoto(tovarna.getFoto());
        setId(tovarna.getId());
        setNazev(tovarna.getNazev());
        this.pocetHal = pocetHal;
    }

    public String getMesto() {
        return mesto;
    }

    public void setMesto(String mesto) {
        this.mesto = mesto;
    }
}
