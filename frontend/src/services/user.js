import BaseService from './base'

export default class UserService extends BaseService {
  constructor() {
    super()
  }

  async login(user) {
    const payload = { email: user.email, password: user.password }
    const response = await this.axios.post(this.SERVICE_URL + 'auth/login', payload)
    if (response.data.token) {
      localStorage.setItem('user', JSON.stringify(response.data));
    }

    return response.data;
  }

  async logout() {
    const user = JSON.parse(localStorage.getItem('user'))
    const payload = {email: user.email}
    await this.axios.post(this.SERVICE_URL + 'auth/logout', payload)
    localStorage.removeItem('user');
  }

  async register(user) {
    const payload = {
      name: user.name,
      surname: user.surname,
      email: user.email,
      password: user.password
    }
    const response = await this.axios.post(API_URL + 'auth/register', payload);

    return response.data
  }
}
