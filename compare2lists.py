import random
rows = 5
lista = [[random.randrange(100) for i in range(10)] for _ in range(rows)]
listb = [[random.randrange(100) for i in range(10)] for _ in range(rows)]

listc = [[i for i in a if i in b] for a,b in zip(lista,listb)]
print(lista)
print(listb)
print('---')
print(listc)
