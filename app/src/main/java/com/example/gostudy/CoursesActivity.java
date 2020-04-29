package com.example.gostudy;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class CoursesActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_courses);
        Button cmBtn = findViewById(R.id.firstCourse);
        cmBtn.setOnClickListener(new View.OnClickListener(){

            @Override
            public void onClick(View v) {
                show_cm_page();
            }
        });

        Button calculus1A = findViewById(R.id.secondCourse);
        calculus1A.setOnClickListener(new View.OnClickListener(){

            @Override
            public void onClick(View v) {
                show_calculus_1a();
            }
        });
    }
    private void show_cm_page(){
        Intent intent = new Intent(CoursesActivity.this, CMPage.class);
        startActivity(intent);
    }
    private void show_calculus_1a(){
        Intent intent = new Intent(CoursesActivity.this, CalculusPage.class);
        startActivity(intent);
    }
}
