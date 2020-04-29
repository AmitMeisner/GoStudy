package com.example.gostudy;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button coursesBtn = findViewById(R.id.coursesbtn);
        coursesBtn.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                moveToCoursesScreen();
            }

        });
    }

    private void moveToCoursesScreen(){
        Intent intent = new Intent(MainActivity.this, CoursesActivity.class);
        startActivity(intent);
    }
}

