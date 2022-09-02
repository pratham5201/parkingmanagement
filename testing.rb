require('stripe')

Stripe.api_key = 'sk_test_51LdFA9SANCZEKwhAsHtz1068unX0UQBWujOauuu7MzvoySKcDkCknV2CDB26VgUeEgGz3xoo0PVZRRZ7jveK2Mwv00AWm6JrhC'

print('Enter price: ')
pp = gets.chomp.to_i

price = Stripe::Price.create({
                               unit_amount: pp,
                               currency: 'inr',
                               product: 'prod_MM04XZUGZsX8Ow'
                             })

order = Stripe::PaymentLink.create(
  line_items: [{ price: price.id, quantity: 1 }],
  after_completion: { type: 'redirect', redirect: { url: 'https://shobhitjain.live' } }
)
system('xdg-open', order.url)
