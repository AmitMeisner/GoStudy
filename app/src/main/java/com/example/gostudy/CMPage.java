package com.example.gostudy;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;

public class CMPage extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_c_m_page);
        ImageButton stats = findViewById(R.id.cmStats);
        stats.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                show_my_stats();
            }
        });

        ImageButton tips = findViewById(R.id.cmTips);
        tips.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                show_my_tips();
            }
        });



    }
    private void show_my_stats(){
        Intent intent = new Intent(CMPage.this, CMStats.class);
        startActivity(intent);
    }
    private void show_my_tips(){
        Intent intent = new Intent(CMPage.this, CMMTips.class);
        startActivity(intent);

    }
}
