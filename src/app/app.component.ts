import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  responseMessage!: string;

  constructor (private http: HttpClient){}

  onSubmit(contactForm: any) {
    if (contactForm.valid) {
      const formData = {
        name: contactForm.value.name,
        email: contactForm.value.email,
        message: contactForm.value.message
      };

      this.http.post<any>('http://localhost:3000/api/contact', formData)
        .subscribe(response => {
          if (response.success) {
            this.responseMessage = response.message;
            contactForm.resetForm();
          }
        });
    }
  }
}
